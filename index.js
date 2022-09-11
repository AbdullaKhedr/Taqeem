import express from 'express';
import mongoose from "mongoose";
import router from './server/routes.js';
import morgan from 'morgan';

mongoose.connect(
    'mongodb+srv://scores-app:scores-app@cluster0.jcs45jp.mongodb.net/?retryWrites=true&w=majority',
    {useNewUrlParser: true, useCreateIndex: true, useUnifiedTopology: true},
    async function (err) {
        if (err) {
            console.log("MonogoDB: Failed to connect" + err);
        } else {
            console.log('MonogoDB: Successfully connected');
        }
    });


const port = process.env.PORT || 8000;
const index = express();

index.use(express.static('public/'));
index.use(express.json());
index.use(morgan('dev'));
index.use('/api', router);

index.listen(port, () => {
    console.log(`Server started @http://localhost:${port}`);
});