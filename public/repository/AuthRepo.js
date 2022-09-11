class AuthRepo {
    async login(userName, password) {
        let url = `api/users/login?userName=${userName}&password=${password}`;
        const response = await fetch(url);
        return await response.json();
    }

    setCurrentUser(email) {
        return localStorage.currentUserEmail = email;
    }

    getCurrentUser() {
        return localStorage.currentUserEmail;
    }

    logOutCurrentUser() {
        return delete localStorage.currentUserEmail && delete localStorage.currentUserRole;
    }
}

export default new AuthRepo();