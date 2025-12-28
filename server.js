const express = require("express");
const fs = require("fs");
const path = require("path");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

function readFundings() {
  const data = fs.readFileSync("./fund_bridge/data/fundings.json", "utf8");
  return JSON.parse(data);
}

function writeFundings(fundings) {
  fs.writeFileSync(
    "./fund_bridge/data/fundings.json",
    JSON.stringify(fundings, null, 2)
  );
}

// GET: Return all funding items
app.get("/api/fundings", (req, res) => {
  try {
    const fundings = readFundings();
    res.json(fundings);
  } catch (err) {
    res.status(500).json({ error: "Failed to read funding data" });
  }
});

app.get("/api/fundings/:id", (req, res) => {
  try {
    const fundings = readFundings();
    const item = fundings.find((f) => f.id === parseInt(req.params.id));
    if (!item) {
      return res.status(404).json({ error: "Funding item not found" });
    }
    res.json(item);
  } catch (err) {
    res.status(500).json({ error: "Error reading data" });
  }
});

app.post("/api/fundings", (req, res) => {
  try {
    const fundings = readFundings();

    // Generate new ID Increamentally
    const maxId =
      fundings.length > 0 ? Math.max(...fundings.map((f) => f.id)) : 0;
    const newId = maxId + 1;
    const newPost = {
      id: newId,
      title: req.body.title,
      author: req.body.author,
      description: req.body.description,
      goal_amount: req.body.goal_amount,
      current_amount: 0,
      image: req.body.image,
      category: req.body.category,
      location: req.body.location,
      created_at: new Date().toISOString().split("T")[0],
      supporters_count: 0,
    };
    fundings.push(newPost);
    writeFundings(fundings);

    console.log("Created new post with ID:", newId);
    res.status(201).json(newPost);
  } catch (err) {
    console.error("Error creating post:", err);
    res.status(500).json({ error: "Error creating funding post" });
  }
});

app.patch("/api/fundings", async (req, res) => {
  try {
    const postID = req.body.id;
    console.log("Updating post with ID:", postID);
    const amount = req.body.amount;

    const data = fs.readFileSync("./fund_bridge/data/fundings.json", "utf8");
    // console.log("Current data:", data);
    const posts = JSON.parse(data);
    const post = posts.find((p) => p.id === postID);
    if (!post) {
      return res.status(404).json({ error: "post not found" });
    }
    post.current_amount += amount;
    post.supporters_count++;

    // console.log("Updated post:", post);
    fs.writeFileSync(
      "./fund_bridge/data/fundings.json",
      JSON.stringify(posts, null, 2)
    );
    res.json(post);
  } catch (err) {
    res.status(500).json({ error: "Error updating data" });
  }
});
const PORT = 8000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
