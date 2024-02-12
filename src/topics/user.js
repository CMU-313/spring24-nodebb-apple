'use strict';

const db = require('../database');

module.exports = function (Topics) {
    Topics.isOwner = async function (tid, uid) {
        uid = parseInt(uid, 10);
        // checking if UID is annonymous (-1) or invalid
        // and will automatically return false
        if (uid <= 0) {
            return false;
        }
        const author = await Topics.getTopicField(tid, 'uid');
        // checking if the topic was created anonymously
        if (parseInt(author, 10) === -1) {
            return false;
        }
        return author === uid;
    };

    Topics.getUids = async function (tid) {
        return await db.getSortedSetRevRangeByScore(`tid:${tid}:posters`, 0, -1, '+inf', 1);
    };
};
