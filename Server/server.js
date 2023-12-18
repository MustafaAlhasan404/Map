const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const { log } = require('console');

const app = express();
const PORT = 3000;

// Connect to MongoDB using your provided connection string
mongoose.connect('mongodb+srv://mustafa:mustafa@cluster0.cdvxaix.mongodb.net/?retryWrites=true&w=majority', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
});

const User = mongoose.model('User', {
    username: String,
    password: String,
});

app.use(bodyParser.json());

app.post('/signup', async (req, res) => {
    try {
        const { username, password } = req.body;

        const existingUser = await User.findOne({ username });
        if (existingUser) {
            return res.status(409).json({ error: 'Username already exists' });
        }

        const newUser = new User({ username, password });
        await newUser.save();

        res.status(201).json({ message: 'User created successfully' });
        console.log(`New User created with credentials: ${username}, ${password}`);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal Server Error' });
        console.log(`Internal server error`);
    }
});

app.get("/", async (req, res) => {
    res.status(200).json({ msg: 'Welcome to server' });
})

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
