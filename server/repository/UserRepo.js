import User from '../models/User.js';

class UserRepo {
    async login(userName, password) {
        let res = false;
        await User.find({userName: userName, password: password}, function (err, docs) {
            res = docs.length > 0;
        });
        return res;
    }

    async addUser(user) {
        return User.create(user);
    }
}

export default new UserRepo();
