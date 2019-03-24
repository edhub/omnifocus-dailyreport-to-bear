# omnifocus-dailyreport-to-bear
This is a scripting file which export tasks in OmniFocus completed yesterday to Bear Note.

## Why I created it
I use OmniFocus a lot. I use Bear Notes a lot.

And I learn x-callback-url by chance.

hmm...

I'll combine them together.

Someone already created a report maker, but the output is going into a file. And I want it go into Bear Notes.

I want to learn automation BTW.

## Usage recommendation
Download the compiled script.

In OmniFocus -> Help -> Open Script Folder. Drop the script in.

OmniFocus -> View -> Customize Toolbar.  Find the script action, add it to the toolbar.

Click the icon. Your report is now finished!

## Configurations
There are some configurations available:

```
    keepNotes: true, // Keeps notes, or not.
    dateLocale: "en-US", // Use zh-CN for Chinese
    compactViewMode: true, // If ture, there's no empty line between entries.
    flaggedTaskMarker: " 🚩", // A marker followed after the name of the task.

    groupTasks: true, // Show task groups: top level folder or project.
    rootFolderMarker: " 📂", // A marker followed after the name of the top level folder name.
    rootProjectMarker: " 💼", // A marker followed after the name of the top level project name.
```

How to update configurations:
1. Open DailyReport.scpt with Script Editor.
2. Find Configuration area.
3. Change the values.