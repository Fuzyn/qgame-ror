import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["planet", "input", "submit"]

    connect() {
        this.currentIndex = null;
        this.originalContent = {}
    }

    addFleet(event) {
        const clickedIndex = event.currentTarget.dataset.index;

        if (this.currentIndex && this.currentIndex !== clickedIndex) {
            this.resetPlanet(this.currentIndex);
        }

        const turboFrame = document.getElementById(`galaxy_planet_${clickedIndex}`);
        if (!this.originalContent[clickedIndex]) {
            this.originalContent[clickedIndex] = turboFrame.innerHTML;
        }

        this.currentIndex = clickedIndex;
    }

    resetSpecificPlanet(e) {
        this.resetPlanet(e.target.dataset.index)
    }

    resetPlanet(index) {
        const turboFrame = document.getElementById(`galaxy_planet_${index}`);

        if (turboFrame) {
            turboFrame.innerHTML = this.originalContent[index];
        }
    }

    validate() {
        let isValid = false;

        this.inputTargets.forEach((input) => {
            if (parseInt(input.value) > 0) {
                isValid = true;
            }
        });

        const submitButton = document.getElementById('submit-validate-button')

        if (submitButton) {
            submitButton.disabled = !isValid;
        }
    }
}