import express from 'express';
import teamsService from "./services/TeamService.js";
import userService from "./services/UserService.js";

const router = express.Router();

router.route('/users/login')
    .get(userService.loginUser)
    .post(userService.addUser)

router.route('/teams')
    .get(teamsService.getTeam)
    .post(teamsService.addTeam)
    .put(teamsService.updateTeam)
    .delete(teamsService.deleteTeam)

export default router;
