/* Time Span START
You can modify the code to make weekly report, Monthly report.
*/
let today = new Date();
today.setHours(0, 0, 0);
let yesterday = new Date();
yesterday.setDate(new Date().getDate() - 1);
yesterday.setHours(0, 0, 0);
// Time Span END

// Configuration START
let cfg = {
    keepNotes: true, // Keeps notes, or not.
    dateLocale: "en-US", // Use zh-CN for Chinese
    compactViewMode: false, // If ture, there's no empty line between entries.

    dateBegin: yesterday,
    dateEnd: today,
};
// Configuration END


/* Tags will be display in the first line of the note body, just below the title.*/
// let noteTags = "#Daily Report# #OmniFocus"; // Static tags
let tagDateOptions = { year: 'numeric', month: '2-digit' };
let noteTags = `#OmniFocus/DailyReport/${cfg.dateBegin.toLocaleDateString(cfg.dateLocale, tagDateOptions)}`; // Use dynamic tags group by month.

let dateOptions = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
let noteTitle = `Daily Report       ${cfg.dateBegin.toLocaleDateString(cfg.dateLocale, dateOptions)}`;

let noteBody = buildBearNoteBody();

saveToBear(noteTitle, noteTags, noteBody);

function getCompletedTasks() {
    let omniDoc = Application('OmniFocus').defaultDocument;
    return omniDoc.flattenedTasks.whose({
        _and: [
            { completed: true },
            { completionDate: { _greaterThan: cfg.dateBegin } },
            { completionDate: { _lessThan: cfg.dateEnd } },
        ]
    })().map(task => {
        return {
            name: task.name(),
            note: task.note().trim(),
            flagged: task.flagged(),
        };
    });
}

function buildBearNoteBody() {
    let tasks = getCompletedTasks();
    let count = tasks.length;
    var description = "";
    for (i = 0; i < count; i++) {
        description += buildDescriptionForATask(tasks[i]);
    }
    return description;
}

function buildDescriptionForATask(task) {
    var description = `+ ${task.name}! ${task.flagged?' 🚩':''}\n`;
    if (cfg.keepNotes && task.note != "") {
        description += `> ${task.note.replace(/\n\n/g,'\n').replace(/\n/g,'\n> ')}\n`;
    }
    if (!cfg.compactViewMode) {
        description += "\n";
    }
    return description;
}

function saveToBear(title, tags, body) {
    let se = Application('System Events');
    se.includeStandardAdditions = true;
    let tagsAndBody = tags + "\n\n" + body;
    let xcmd = `bear://x-callback-url/create?title=${encodeURIComponent(title)}&text=${encodeURIComponent(tagsAndBody)}`;
    se.openLocation(xcmd);
}