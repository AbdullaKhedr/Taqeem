import teamsRepo from "../repository/TeamsRepo.js";
import {access, mkdir, readFile, writeFile} from "fs/promises";
import formidable from "formidable";

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
            if (req.query.leader) {
                res.status(200).json(await teamsRepo.getTeamsByLeader(req.query.leader));
            } else if (req.query._id) {
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

    async uploadTeamPicture(req, res) {
        try {
            const teamId = req.params.teamId;
            const formData = formidable({multiples: true});
            formData.parse(req, async (err, fields, files) => {
                const uploadedFiles = [];
                try {
                    await access('./public/attachments/');
                } catch (e) {
                    await mkdir('./public/attachments/');
                }
                try {
                    await access(`./public/attachments/${teamId}`);
                } catch (e) {
                    await mkdir(`./public/attachments/${teamId}`);
                }
                if (Array.isArray(files.attachments)) {
                    for (let file of files.attachments) {
                        const fileName = file.name;
                        const fileContent = await readFile(file.path);
                        await writeFile(`./public/attachments/${teamId}/${fileName}`, fileContent);
                        uploadedFiles.push({
                            filePath: `/attachments/${teamId}/${fileName}`,
                            fileName: fileName
                        });
                    }
                } else {
                    const fileName = files.attachments.name;
                    const fileContent = await readFile(files.attachments.path);
                    await writeFile(`./public/attachments/${teamId}/${fileName}`, fileContent);
                    uploadedFiles.push({
                        filePath: `/attachments/${teamId}/${fileName}`,
                        fileName: fileName
                    });
                }
                fields.attachments = uploadedFiles;
                await teamsRepo.addTeam(admissionId, uploadedFiles);
                res.status(201).send('Team Created Successfully');
            });
        } catch (error) {
            res.status(500).send(error);
        }
    }
}

export default new TeamService();
