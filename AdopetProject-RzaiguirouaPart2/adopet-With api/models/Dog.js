const mongoose = require('mongoose');

const DogSchema = new mongoose.Schema({
  name: String,
  age: Number,
  gender: String,
  color: String,
  weight: Number,
  distance: String,
  imageUrl: String,
  description: String,
  owner: {
    name: String,
    bio: String,
    imageUrl: String,
  },
});

module.exports = mongoose.model('Dog', DogSchema);
