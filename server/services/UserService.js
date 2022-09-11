import userRepo from "../repository/UserRepo.js";

class UserService {
    async loginUser(req, res) {
        try {
            const userName = req.query.userName;
            const password = req.query.password;
            res.status(201).json(await userRepo.login(userName, password));
        } catch (error) {
            res.status(500).send(error);
        }
    }

    async addUser(req, res) {
        try {
            const user = req.body;
            await userRepo.addUser(user);
            res.status(201).send('User added Successfully');
        } catch (error) {
            res.status(500).send(error);
        }
    }
}

export default new UserService();
