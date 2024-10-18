import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    fetchAndRefresh(event) {
        const planetId = event.target.value;

        fetch(`/change_planet/${planetId}`, {
            method: 'GET',
            headers: {"Accept": "application/json"}
        })
            .then(response => {
                if (response.ok) {
                    return response;
                }
            })
            .then(data => {
                window.location.reload();
            })
            .catch(error => {
                console.error("There was a problem:", error);
            });
    }
}