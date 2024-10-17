import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["content"];
    static values = { id: Number };

    toggleMessage(event) {
        const content = this.contentTarget;
        content.classList.toggle("hidden");

        if (event.currentTarget.dataset.messageMarkReadUrl && event.currentTarget.classList.contains('unread')) {
            this.markAsRead(event.currentTarget.dataset.messageMarkReadUrl);
            event.currentTarget.querySelector('span').remove()
        }
    }

    markAsRead(url) {
        fetch(url, {
            method: "POST",
            headers: {
                "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
                "Accept": "text/vnd.turbo-stream.html",
            },
        })
            .then(response => {
                if (response.ok) {
                    const unreadSpan = this.element.querySelector(".unread");
                    if (unreadSpan) {
                        unreadSpan.classList.remove("unread");
                        this.updateUnreadCount();
                    }
                } else {
                    console.error("Error marking message as read:", response.statusText);
                }
            })
            .catch(error => console.error("Fetch error:", error));
    }

    updateUnreadCount() {
        const categoryTitle = this.element.dataset.categoryTitle;
        const unreadCountElement = document.querySelector(
            `[data-category-title="${categoryTitle}"] .unread-count`
        );

        const unreadTitleElement = document.querySelector(
            `[data-category-title="${categoryTitle}"]`
        );

        if (unreadCountElement) {
            let unreadCount = parseInt(unreadCountElement.innerText);
            if (unreadCount > 0) {
                const newValue = unreadCount - 1
                unreadCountElement.innerText = newValue;
9
                if (unreadTitleElement && newValue === 0) {
                    unreadTitleElement.classList.remove("unread")
                }
            }
        }
    }
}