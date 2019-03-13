let today = new Date();
today.setHours(0,0,0);
let yesterday = new Date(today.getTime() - 24*60*60*1000);

var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
let noteTitle = `Daily Report       ${yesterday.toLocaleDateString('zh-CN', options)}`;

let tasks = getCompletedTasksYesterday();
let noteBody = buildBearNoteBody(tasks);

saveToBear(noteTitle, noteBody);


function getCompletedTasksYesterday(){
    let omnif = Application('OmniFocus');
    return omnif.defaultDocument.flattenedTasks.whose({
        _and:[
            {completed: true},
            {completionDate: {_greaterThan: yesterday}},
            {completionDate: {_lessThan: today}},
        ]
    });
}

function buildBearNoteBody(tasks){
    let tagOption = {year: 'numeric', month: '2-digit' };
    let noteTags = `OmniFocus/DailyReport/${yesterday.toLocaleDateString('zh-CN', tagOption)}\n\n`;
    let count = tasks.length;
    var description = "#"+ noteTags;
    for (i = 0; i < count; i++){
        description += buildDescriptionForATask(tasks[i]);
    }
    return description;
}

function buildDescriptionForATask(task){
    var description = `+ ${task.name()}! ${task.flagged()?' 🚩':''}\n`;
    let note = task.note() ? task.note().trim() : "";
    if (note != "") {
        description += `> ${note.replace(/\n\n/g,'\n').replace(/\n/g,'\n> ')}\n`;
    }
    description += "\n";
    return description;
}

function saveToBear(title, body){
    let se = Application('System Events');
    se.includeStandardAdditions = true;
    let xcmd = `bear://x-callback-url/create?title=${encodeURIComponent(title)}&text=${encodeURIComponent(body)}`;
    se.openLocation(xcmd);
}