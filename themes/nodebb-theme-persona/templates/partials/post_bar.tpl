<div class="topic-main-buttons pull-right inline-block">
    <span class="loading-indicator btn pull-left hidden" done="0">
        <span class="hidden-xs">[[topic:loading_more_posts]]</span> <i class="fa fa-refresh fa-spin"></i>
    </span>

    <!-- IF loggedIn -->
    <button component="topic/mark-unread" class="btn btn-sm btn-default" title="[[topic:mark_unread]]">
        <i class="fa fa-fw fa-inbox"></i><span class="visible-sm-inline visible-md-inline visible-lg-inline"></span>
    </button>
    <!-- ENDIF loggedIn -->

    <!-- Here, we add the lock/unlock buttons based on the user's privilege to lock/unlock the post -->
    <!-- IF canLockPost -->
    <button component="post/lock" class="btn btn-sm btn-default" title="[[topic:lock_post]]">
        <i class="fa fa-fw fa-lock"></i><span class="visible-sm-inline visible-md-inline visible-lg-inline"> Lock</span>
    </button>
    <!-- ELSE -->
    <button component="post/unlock" class="btn btn-sm btn-default" title="[[topic:unlock_post]]">
        <i class="fa fa-fw fa-unlock"></i><span class="visible-sm-inline visible-md-inline visible-lg-inline"> Unlock</span>
    </button>
    <!-- ENDIF canLockPost -->

    <!-- IMPORT partials/topic/watch.tpl -->

    <!-- IMPORT partials/topic/sort.tpl -->

    <div class="inline-block">
    <!-- IMPORT partials/thread_tools.tpl -->
    </div>
    <!-- IMPORT partials/topic/reply-button.tpl -->

<script>
document.addEventListener('DOMContentLoaded', function() {
    console.log('Script is loading...');

    // Directly attempting to use ajaxify.data.tid, assuming it's available
    const topicId = typeof ajaxify !== 'undefined' ? ajaxify.data.tid : null;
    console.log('Current topic ID:', topicId);

    if (!topicId) {
        console.error('Topic ID could not be determined.');
        return; // Exit if the topic ID wasn't found
    }

    const lockButton = document.querySelector('[component="post/lock"]');
    const unlockButton = document.querySelector('[component="post/unlock"]');

    function toggleLockState(isLocked) {
        lockButton.style.display = isLocked ? 'none' : 'inline-block';
        unlockButton.style.display = isLocked ? 'inline-block' : 'none';
    }

    // Function to handle the fetch request and button state toggle
    function handleFetch(method) {
        const requestUrl = "/api/v3/topics/" + topicId + "/lock";
        console.log("Making request to:", requestUrl);

        fetch(requestUrl, {
            method: method,
            headers: {
                'x-csrf-token': config.csrf_token,
                'Content-Type': 'application/json',
            },
            credentials: 'include'
        })
        .then(response => {
            if (response.ok) {
                console.log(`Topic ${method === 'PUT' ? 'locked' : 'unlocked'} successfully`);
                toggleLockState(method === 'PUT');
            } else {
                console.error(`Error ${method === 'PUT' ? 'locking' : 'unlocking'} topic`);
            }
        })
        .catch(err => console.error('Fetch error:', err));
    }

    lockButton?.addEventListener('click', function() { handleFetch('PUT'); });
    unlockButton?.addEventListener('click', function() { handleFetch('DELETE'); });
});
</script>




</div>
