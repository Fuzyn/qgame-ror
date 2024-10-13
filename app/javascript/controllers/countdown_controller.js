import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static values = { seconds: Number, redirectUrl: String }

    connect() {
        this.remainingSeconds = this.secondsValue
        this.updateCountdown()
        this.startCountdown()
    }

    startCountdown() {
        this.interval = setInterval(() => {
            this.remainingSeconds -= 1
            this.updateCountdown()

            if (this.remainingSeconds <= 0) {
                clearInterval(this.interval)
                this.redirectToShipyard()
            }
        }, 1000)
    }

    updateCountdown() {
        this.element.textContent = this.formatTime(this.remainingSeconds)
    }

    formatTime(seconds) {
        seconds = seconds < 0 ? 0 : seconds
        const hours = String(Math.floor(seconds / 3600)).padStart(2, '0')
        const minutes = String(Math.floor((seconds % 3600) / 60)).padStart(2, '0')
        const secs = String(Math.floor(seconds % 60)).padStart(2, '0')
        return `${hours}:${minutes}:${secs}`
    }

    redirectToShipyard() {
        setTimeout(() => {
            window.location.href = this.redirectUrlValue
        }, 1000)
    }

    disconnect() {
        clearInterval(this.interval)
    }
}