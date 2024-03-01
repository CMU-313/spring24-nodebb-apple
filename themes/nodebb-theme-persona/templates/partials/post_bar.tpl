<div class="topic-main-buttons pull-right inline-block">
    <span class="loading-indicator btn pull-left hidden" done="0">
        <span class="hidden-xs">[[topic:loading_more_posts]]</span> <i class="fa fa-refresh fa-spin"></i>
    </span>

    <!-- IF loggedIn -->
    <button component="topic/mark-unread" class="btn btn-sm btn-default" title="[[topic:mark_unread]]">
        <i class="fa fa-fw fa-inbox"></i><span class="visible-sm-inline visible-md-inline visible-lg-inline"></span>
    </button>
    <!-- ENDIF loggedIn -->

    <!-- Conditional display of lock/unlock buttons based on user's privilege -->
    <!-- IF canLockPost -->
    <button component="post/lock" class="btn btn-sm btn-default" title="[[topic:lock_post]]">
        <i class="fa fa-fw fa-lock"></i> Lock
    </button>
    <!-- ELSE -->
    <button component="post/unlock" class="btn btn-sm btn-default" title="[[topic:unlock_post]]" style="display: none;">
        <i class="fa fa-fw fa-unlock"></i> Unlock
    </button>
    <!-- ENDIF canLockPost -->

    <!-- IMPORT partials/topic/watch.tpl -->
    <!-- IMPORT partials/topic/sort.tpl -->

    <div class="inline-block">
        <!-- IMPORT partials/thread_tools.tpl -->
    </div>
    <!-- IMPORT partials/topic/reply-button.tpl -->
</div>
<script>
function runScript() {
    $(window).on('ajaxify.end', function() {
        console.log('Page fully loaded, including dynamic content.');

        const topicId = typeof ajaxify !== 'undefined' ? ajaxify.data.tid : null;
        console.log('Current topic ID:', topicId);

        if (!topicId) {
            console.error('Topic ID could not be determined.');
            return;
        }

        function handleFetch(method) {
            const action = method === 'PUT' ? 'lock' : 'unlock';
            console.log(`Attempting to ${action} the topic with ID: ${topicId}`);

            fetch(`/api/v3/topics/${topicId}/lock`, {
                method: method,
                headers: {
                    'x-csrf-token': config.csrf_token,
                    'Content-Type': 'application/json',
                },
                credentials: 'include'
            })
            .then(response => {
                if (response.ok) {
                    console.log(`Topic ${action}ed successfully.`);
                    $(document).trigger('lockStateChange', [method === 'PUT']);
                } else {
                    console.error(`Error ${action}ing topic.`);
                }
            })
            .catch(err => console.error('Fetch error:', err));
        }

        $(document).on('click', '[component="post/lock"]', function() { handleFetch('PUT'); });
        $(document).on('click', '[component="post/unlock"]', function() { handleFetch('DELETE'); });

        $(document).on('lockStateChange', function(e, isLocked) {

                        const lockButton = $('[component="post/lock"]');
            const unlockButton = $('[component="post/unlock"]');

            lockButton.css('display', isLocked ? 'none' : 'inline-block');
            unlockButton.css('display', isLocked ? 'inline-block' : 'none');

        });
    });
}

if (typeof $ !== 'undefined') {
    runScript();
} else {
    var checkjQuery = setInterval(function() {
        if (typeof $ !== 'undefined') {
            clearInterval(checkjQuery);
            runScript();
        }
    }, 100);
}
</script>