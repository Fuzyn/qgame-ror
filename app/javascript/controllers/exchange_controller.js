import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["fromResource", "toResource", "amount", "exchangeInfo"]

    connect() {
        this.resourceValues = {
            metal: 1,
            crystal: 2,
            deuterium: 4
        }
    }

    calculate() {
        const amount = parseInt(this.amountTarget.value)
        const from = this.fromResourceTarget.value
        const to = this.toResourceTarget.value

        if (amount && from && to && from !== to) {
            const fromValue = this.resourceValues[from]
            const toValue = this.resourceValues[to]

            const exchangeAmount = Math.floor(amount * fromValue / toValue)

            this.exchangeInfoTarget.innerHTML = `You will receive ${exchangeAmount} ${to.charAt(0).toUpperCase() + to.slice(1)}.`
        } else {
            this.exchangeInfoTarget.innerHTML = ''
        }
    }
}