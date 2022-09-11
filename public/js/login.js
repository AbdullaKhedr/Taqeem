import authRepo from '../repository/AuthRepo.js';

const loginEmail = document.querySelector('#username');
const loginPassword = document.querySelector('#password');

const loginForm = document.querySelector('#login_form');
loginForm.addEventListener('submit', login);

// Once the user open the home page, check if there is a current User logged in,
// if so navigate to Dashboard (Admissions Table)
const currentUser = await authRepo.getCurrentUser();
if (currentUser) window.location = "../main.html";
console.log("Current User: ", currentUser);

async function login(event) {
    if (!loginForm.checkValidity()) return
    // Prevent default action of the submit button
    event.preventDefault();

    // Start do what i want to happen on submit clicked
    const login = await authRepo.login(loginEmail.value, loginPassword.value);
    console.log("User to login: ", login);

    if (login) {
        alert("Welcome");
        authRepo.setCurrentUser(loginEmail.value);
        loginForm.reset();
        window.location = "../main.html";
    } else {
        alert("Login Failed");
    }
}