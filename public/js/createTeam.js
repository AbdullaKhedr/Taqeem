import teamRepo from '../repository/TeamsRepo.js';
import authRepo from '../repository/AuthRepo.js';

document.addEventListener("DOMContentLoaded", async () => {
    window.addGroup = addGroup
    window.removeGroup = removeGroup
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

    const Team = {
        name: team_name.value,
        leader: authRepo.getCurrentUser(),
        picture: "",
        score: 0,
        groups: groups_list_holder.map((e) => {
            return {
                name: e,
                members: []
            }
        })

    }
    console.log(JSON.stringify(Team));
    alert(JSON.stringify(Team))
    await teamRepo.addTeam(Team);
    history.back();
}

function addGroup() {
    const group_name = document.querySelector('#group_name');
    groups_list_holder.push(group_name.value);
    renderGroupsList();
    group_name.value = ""
}

function removeGroup(id) {
    delete groups_list_holder[id];
    renderGroupsList();
}

function renderGroupsList() {
    group_list.innerHTML = "";
    groups_list_holder.map((element, index) => {
        group_list.innerHTML +=
            `<div class="" id="group${index}">
                    <div class="card">
                    <div class="input-group-append">
                    <button class="btn btn-danger btn-sm rounded-2" 
                    type="button" 
                    data-toggle="tooltip"
                    data-placement="top" title="" data-original-title="Delete"
                    onclick="removeGroup('${index}')">
                    <i class="fa fa-trash"></i>
                    </button>
                    <h3 class="w-100" dir="rtl">
                    ${element}
                    </h3>
                    </div>
                    </div>
                <br class="mb-1">
                </div>`
    })
}

function formToObject(formElement) {
    const formData = new FormData(formElement);
    const data = {};
    for (const [key, value] of formData) {
        data[key] = value;
    }
    return data;
}