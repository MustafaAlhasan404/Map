const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const cors = require('cors'); // Add cors middleware

const app = express();
const port = 3000;

// Middleware
app.use(cors()); // Enable CORS
app.use(bodyParser.json());

// Connect to MongoDB using your provided connection string
mongoose.connect('mongodb+srv://mustafa:mustafa@cluster0.cdvxaix.mongodb.net/test', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
});

// Create a mongoose schema for the user
const userSchema = new mongoose.Schema({
    username: String,
    password: String,
});

// Create a mongoose model based on the schema
const User = mongoose.model('User', userSchema);

// Endpoint for handling signup
app.post('/signup', async (req, res) => {
    const { username, password } = req.body;

    try {
        console.log('Received signup request:', { username, password });

        // Check if username already exists
        const existingUser = await User.findOne({ username });
        if (existingUser) {
            console.log('Username already exists');
            return res.status(400).json({ error: 'Username already exists' });
        }

        // Save user to the database
        const newUser = new User({ username, password });
        await newUser.save();

        // You can perform additional tasks here (e.g., send confirmation email)

        // Respond with success
        console.log('Signup successful');
        res.status(200).json({ message: 'Signup successful' });
    } catch (error) {
        // Handle database or server errors
        console.error('Error:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
