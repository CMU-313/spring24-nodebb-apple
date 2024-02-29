<div class="topic-main-buttons pull-right inline-block">
    <span class="loading-indicator btn pull-left hidden" done="0">
        <span class="hidden-xs">[[topic:loading_more_posts]]</span> <i class="fa fa-refresh fa-spin"></i>
    </span>

    <!-- IF loggedIn -->
    <button component="topic/mark-unread" class="btn btn-sm btn-default" title="[[topic:mark_unread]]">
        <i class="fa fa-fw fa-inbox"></i><span class="visible-sm-inline visible-md-inline visible-lg-inline"></span>
    </button>
    <!-- ENDIF loggedIn -->

    <!-- IMPORT partials/topic/watch.tpl -->

    <!-- IMPORT partials/topic/sort.tpl -->

    <div class="inline-block">
    <!-- IMPORT partials/thread_tools.tpl -->
    </div>
    <!-- IMPORT partials/topic/reply-button.tpl -->
    <!-- Code written by ChatGPT -->
    <!-- Add Resolve button only available to users with correct privileges to resolve the topic -->
    <!-- IF privileges.can_resolve -->
        <button 
        component="topic/resolve" 
        class="btn btn-sm btn-default" 
        type="button" 
        {{{if resolve}}}disabled{{{end}}}>
        <!-- Button content changes based on resolution state -->
        {{{if resolve}}}
            <!-- Displayed if the topic is already resolved -->
            <i class="fa fa-fw fa-check"></i>
            <span class="visible-sm-inline visible-md-inline visible-lg-inline">Already Resolved</span>
        {{{else}}}
            <!-- Displayed if the topic is not resolved yet -->
            <i class="fa"></i>
            <span class="visible-sm-inline visible-md-inline visible-lg-inline">Mark as Resolved</span>
        {{{end}}}
    </button> 
    <!-- ENDIF privileges.can_resolve -->
</div>
