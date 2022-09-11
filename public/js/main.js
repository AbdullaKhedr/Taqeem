import teamsRepo from '../repository/TeamsRepo.js';
import authRepo from '../repository/AuthRepo.js';

document.addEventListener("DOMContentLoaded", async () => {
    window.getTeams = getTeams;

    await getTeams();
});

const team_img = document.querySelector('#team_img');
const team_name = document.querySelector('#team_name');
const team_card = document.querySelector('.team_card');

async function getTeams() {
    const teams = await teamsRepo.getTeams(authRepo.getCurrentUser());

    console.log(teams);
}

