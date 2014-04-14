// This is a test harness for your module
// You should do something interesting in this harness
// to test out the module and to provide instructions
// to users on how to use it by example.

// open a single window
var win = Ti.UI.createWindow({
    backgroundColor: 'white'
});

var savedText = Ti.UI.createTextField({
    width: 250,
    height: 60,
    top: 20,
    borderStyle: 1
});
win.add(savedText);

var saveButton = Ti.UI.createButton({
    title: "Save Setting"
});
win.add(saveButton);

win.open();

var iCloudModule = require('com.lightapps.icloudkeyvalue');
Ti.API.info("module is => " + iCloudModule);

savedText.value = iCloudModule.getString({
    key: "testKey"
});

saveButton.addEventListener('click', function (e) {
    iCloudModule.setString({
        key: "testKey",
        value: savedText.value
    });
});
