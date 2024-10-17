import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["content"];

    toggleCategory(event) {
        const content = event.currentTarget.nextElementSibling;
        content.classList.toggle("hidden");
    }
}