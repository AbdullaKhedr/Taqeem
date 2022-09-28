import teamsRepo from '../repository/TeamsRepo.js';
import authRepo from '../repository/AuthRepo.js';

document.addEventListener("DOMContentLoaded", async () => {
    window.getTeams = getTeams;

    await getTeams();
});

const content = document.querySelector('#content');

const team_img = document.querySelector('#team_img');
const team_name = document.querySelector('#team_name');
const team_card = document.querySelector('.team_card');

async function getTeams() {
    const teams = await teamsRepo.getTeams(authRepo.getCurrentUser());

    console.log(teams);

    content.innerHTML = `
    <div class="container">
            <div class="team_card">
                <div>
                    <img id="team_img"
                         src="data:image/jpeg;base64,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">
                    <h2 id="team_name">Team 1</h2>
                </div>
            </div>
        </div>
    `

}

