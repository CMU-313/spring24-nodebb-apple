<div class="topic-main-buttons pull-right inline-block">
    <span class="loading-indicator btn pull-left hidden" done="0">
        <span class="hidden-xs">[[topic:loading_more_posts]]</span> <i class="fa fa-refresh fa-spin"></i>
    </span>

    <!-- IF loggedIn -->
    <button component="topic/mark-unread" class="btn btn-sm btn-default" title="[[topic:mark_unread]]">
        <i class="fa fa-fw fa-inbox"></i><span class="visible-sm-inline visible-md-inline visible-lg-inline"></span>
    </button>
    <!-- ENDIF loggedIn -->
    <!-- IF canLockPost -->
    <button component="post/lock" data-tid="123" class="btn btn-sm btn-default" title="Lock Topic">
        <i class="fa fa-fw fa-lock"></i> Lock
    </button>
    <!-- ELSE -->
    <button component="post/unlock" data-tid="123" class="btn btn-sm btn-default" title="Unlock Topic" style="display:none;">
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
document.addEventListener('DOMContentLoaded', function() {
    // Example assumes buttons are initially rendered based on the server-side lock state
    const lockButton = document.querySelector('[component="post/lock"]');
    const unlockButton = document.querySelector('[component="post/unlock"]');

    // Function to toggle button visibility
    function toggleLockState(isLocked) {
        if (isLocked) {
            lockButton.style.display = 'none';
            unlockButton.style.display = 'inline-block';
        } else {
            lockButton.style.display = 'inline-block';
            unlockButton.style.display = 'none';
        }
    }

    // Event listener for the lock button
    if (lockButton) {
        lockButton.addEventListener('click', function() {
            var pid = this.getAttribute('data-pid');
            fetch('/api/v2/posts/' + pid + '/lock', {
                method: 'PUT',
                headers: {
                    'x-csrf-token': config.csrf_token,
                    'Content-Type': 'application/json',
                },
                credentials: 'include'
            })
            .then(response => {
                if (response.ok) {
                    console.log('Post locked successfully');
                    toggleLockState(true); // Update buttons to reflect the locked state
                } else {
                    console.error('Error locking post');
                }
            });
        });
    }

    // Event listener for the unlock button
    if (unlockButton) {
        unlockButton.addEventListener('click', function() {
            var pid = this.getAttribute('data-pid');
            fetch('/api/v2/posts/' + pid + '/unlock', {
                method: 'DELETE',
                headers: {
                    'x-csrf-token': config.csrf_token,
                    'Content-Type': 'application/json',
                },
                credentials: 'include'
            })
            .then(response => {
                if (response.ok) {
                    console.log('Post unlocked successfully');
                    toggleLockState(false); // Update buttons to reflect the unlocked state
                } else {
                    console.error('Error unlocking post');
                }
            });
        });
    }
});
</script>
