document.addEventListener('DOMContentLoaded', function() {
    const lockButton = document.querySelector('[component="post/lock"]');
    const unlockButton = document.querySelector('[component="post/unlock"]');

    if (lockButton) {
        lockButton.addEventListener('click', function() {
            var pid = this.getAttribute('data-pid'); // Ensure you have a way to get the correct post ID
            fetch('/api/v2/posts/' + pid + '/lock', {
                method: 'PUT',
                headers: {
                    'x-csrf-token': config.csrf_token, // Use CSRF token from NodeBB config
                    'Content-Type': 'application/json'
                },
                credentials: 'include' // Necessary for cookies, which includes the session
            })
            .then(response => {
                if (response.ok) {
                    console.log('Post locked successfully');
                    // Here you can add code to change the button to unlock or update the UI accordingly
                } else {
                    console.error('Error locking post');
                }
            });
        });
    }

    if (unlockButton) {
        unlockButton.addEventListener('click', function() {
            var pid = this.getAttribute('data-pid'); // Ensure you have a way to get the correct post ID
            fetch('/api/v2/posts/' + pid + '/unlock', {
                method: 'DELETE',
                headers: {
                    'x-csrf-token': config.csrf_token, // Use CSRF token from NodeBB config
                    'Content-Type': 'application/json'
                },
                credentials: 'include' // Necessary for cookies, which includes the session
            })
            .then(response => {
                if (response.ok) {
                    console.log('Post unlocked successfully');
                    // Here you can add code to change the button to lock or update the UI accordingly
                } else {
                    console.error('Error unlocking post');
                }
            });
        });
    }
});
