import Team from '../models/Team.js';

class TeamsRepo {
    async addTeam(team) {
        return Team.create(team);
    }

    async updateTeam(team) {
        return Team.update(team);
    }

    async getTeamById(id) {
        return Team.find({_id: id});
    }

    async getAllTeams() {
        return Team.find({});
    }

    async deleteTeam(id) {
        console.log(id)
        return Team.deleteOne({_id: id});
    }
}

export default new TeamsRepo();
