import mongoose from 'mongoose';

const Team = mongoose.model('Team', new mongoose.Schema({
    name: {type: String, required: [true, 'Name cannot be empty'], unique: true},
    picture: {type: String},
    leader: {type: String, required: [true, 'Leader cannot be empty'], unique: true},
    groups: [{
        name: {type: String, required: [true, 'Name cannot be empty'], unique: true},
        picture: {type: String},
        members: [{
            name: {type: String, required: [true, 'Member name cannot be empty']},
            score: {type: Number, min: 0}
        }],
        score: {type: Number, min: 0}
    }]
}));

export default Team