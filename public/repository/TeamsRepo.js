class TeamsRepo {
    async addTeam(team) {
        let url = `/api/teams`;
        const configs = {
            method: 'POST',
            headers: {'Content-type': 'application/json'},
            body: JSON.stringify(team)
        }
        return await fetch(url, configs);
    }

    async getTeams(userName) {
        let url = `/api/leader?=${userName}`;
        const response = await fetch(url);
        return await response.json();
    }
}

export default new TeamsRepo();