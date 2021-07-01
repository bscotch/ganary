const express = require("express");
const app = express();
const port = 4000;
const fs = require("fs");

app.use(express.urlencoded({ extended: false }));
app.use(express.json());

app.post("/", (req, res) => {
  const payload = req.body;
  console.log(payload);
  fs.writeFileSync("./grc_test.olympus.json", JSON.stringify(payload));
  res.send("Received");
});

app.listen(port, () => {
  console.log(`Listening for Olympus output at http://localhost:${port}`);
});
