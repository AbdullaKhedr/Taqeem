import teamsRepo from "../repository/TeamsRepo.js";

class TeamService {
    async addTeam(req, res) {
        try {
            const team = req.body;
            await teamsRepo.addTeam(team);
            res.status(201).send('Team added Successfully');
        } catch (error) {
            res.status(500).send(error);
        }
    }

    async updateTeam(req, res) {
        try {
            const team = req.body;
            await teamsRepo.updateTeam(team);
            res.status(201).send('Application updated Successfully');
        } catch (error) {
            res.status(500).send(error);
        }
    }

    async getTeam(req, res) {
        try {
            if (req.query._id) {
                res.status(200).json(await teamsRepo.getTeamById(req.query._id));
            } else {
                res.status(200).json(await teamsRepo.getAllTeams());
            }
        } catch (error) {
            res.status(500).send(error);
        }
    }

    async deleteTeam(req, res) {
        try {
            const id = req.query.id;
            if (id) await teamsRepo.deleteTeam(id);
            res.status(201).send('Team deleted Successfully');
        } catch (error) {
            res.status(500).send(error);
        }
    }
}

export default new TeamService();
