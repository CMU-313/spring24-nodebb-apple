'use strict';

const db = require('../database');

module.exports = function (User) {
    User.getIgnoredTids = async function (uid, start, stop) {
        return await db.getSortedSetRevRange(`uid:${uid}:ignored_tids`, start, stop);
    };

    User.addTopicIdToUser = async function (uid, tid, timestamp) {
        if (parseInt(uid, 10) === -1) {
            // If UID is -1, the topic is anonymous, and no action is needed
            return;
        }
        await Promise.all([
            db.sortedSetAdd(`uid:${uid}:topics`, timestamp, tid),
            User.incrementUserFieldBy(uid, 'topiccount', 1),
        ]);
    };
};
