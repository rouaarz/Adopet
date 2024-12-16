const express = require('express');
const Dog = require('../models/Dog');
const router = express.Router();

router.post('/dogs', async (req, res) => {
  try {
    const dog = new Dog(req.body);
    await dog.save();
    res.status(201).json(dog);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/dogs', async (req, res) => {
  try {
    const dogs = await Dog.find();
    res.json(dogs);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.put('/dogs/:id', async (req, res) => {
  try {
    const dog = await Dog.findByIdAndUpdate(req.params.id, req.body, { new: true });
    res.json(dog);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.delete('/dogs/:id', async (req, res) => {
  try {
    await Dog.findByIdAndDelete(req.params.id);
    res.json({ message: 'Dog deleted successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
