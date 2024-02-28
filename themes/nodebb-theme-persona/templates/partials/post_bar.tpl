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
