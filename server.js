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
    console.log("Updated post:", post);
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
