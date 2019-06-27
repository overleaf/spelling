const MongoJS = require("mongojs");
const Settings = require("settings-sharelatex");
module.exports = MongoJS(Settings.mongo.url, ["spellingPreferences"]);

