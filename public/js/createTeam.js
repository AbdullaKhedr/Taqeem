import teamRepo from '../repository/TeamsRepo.js';
import authRepo from '../repository/AuthRepo.js';

document.addEventListener("DOMContentLoaded", async () => {
    window.addGroup = addGroup
    window.removeGroup = removeGroup
    window.addGroupListItem = addGroupListItem
});
let groupsCounter = 1;
const team_name = document.querySelector('#team_name');
const group_list = document.querySelector('#groups-list');
const groups_list_holder = []

const createTeamForm = document.querySelector('#create_team');
createTeamForm.addEventListener('submit', createTeam);

async function createTeam(event) {
    if (!createTeamForm.checkValidity()) return
    // Prevent default action of the submit button
    event.preventDefault();

    const team = formToObject(createTeamForm);
    alert(JSON.stringify(team))
    await teamRepo.addTeam({
        name: team_name,
        leader: authRepo.getCurrentUser(),
        groups: [{
            name: "",
            members: []
        }]
    });
    createTeamForm.action = `/api/teams/`;
    history.back();
}

function addGroup() {
    const name = `group${groupsCounter}`;
    group_list.innerHTML +=
        `<div class="input-group" id="${name}">
                    <div class="input-group-append">
                    <button class="btn btn-danger btn-sm rounded-2" 
                     type="button" 
                     data-toggle="tooltip"
                     data-placement="top" title="" data-original-title="Delete"
                     onclick="removeGroup('${name}')"
                     >
                         <i class="fa fa-trash"></i>
                     </button>
                    </div>
                    <input
                    name="${name}"
                    type="text"
                            class="form-control"
                            id="team_name"
                            placeholder="اسم الجموعة"
                            required
                    >
                </div>
                <br class="mb-1">
`
    groupsCounter++;
}

function removeGroup(id) {
    document.querySelector(`#${id}`).remove();
}

function formToObject(formElement) {
    const formData = new FormData(formElement);
    const data = {};
    for (const [key, value] of formData) {
        data[key] = value;
    }
    return data;
}