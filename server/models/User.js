import mongoose from 'mongoose';

const User = mongoose.model('User', new mongoose.Schema({
    userName: {type: String, required: [true, 'Username cannot be empty'], unique: true},
    password: {type: String, required: [true, 'Password cannot be empty']},
    name: {type: String, required: [true, 'Name cannot be empty']},
    role: {type: String, required: [true, 'Role cannot be empty'], unique: true}
}));

export default User;
