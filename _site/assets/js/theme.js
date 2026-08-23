const toggle = document.getElementById("theme-toggle");

const savedTheme = localStorage.getItem("theme");

if (savedTheme === "night") {
  document.body.classList.add("night-mode");
  toggle.textContent = "☀";
  toggle.setAttribute("aria-label", "Switch to day mode");
}

toggle.addEventListener("click", () => {
  const isNight = document.body.classList.toggle("night-mode");

  if (isNight) {
    localStorage.setItem("theme", "night");
    toggle.textContent = "☀";
    toggle.setAttribute("aria-label", "Switch to day mode");
  } else {
    localStorage.setItem("theme", "day");
    toggle.textContent = "☾";
    toggle.setAttribute("aria-label", "Switch to night mode");
  }
});
