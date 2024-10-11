let taskList = [];

function addTask() {
    const taskInput = document.getElementById('new-task');
    const taskText = taskInput.value.trim();

    if (taskText) {
        const task = {
            id: Date.now(),
            text: taskText,
            isCompleted: false,
        };
        taskList.push(task);
        taskInput.value = '';
        renderTasks();
    }
}

function deleteTask(id) {
    taskList = taskList.filter(task => task.id !== id);
    renderTasks();
}

function editTask(id) {
    const newTaskText = prompt('Edit your task:');
    if (newTaskText) {
        taskList = taskList.map(task => 
            task.id === id ? { ...task, text: newTaskText } : task
        );
        renderTasks();
    }
}

function toggleTaskCompletion(id) {
    taskList = taskList.map(task => 
        task.id === id ? { ...task, isCompleted: !task.isCompleted } : task
    );
    renderTasks();
}

function renderTasks() {
    const taskListElement = document.getElementById('task-list');
    taskListElement.innerHTML = '';

    taskList.forEach(task => {
        const li = document.createElement('li');
        li.className = task.isCompleted ? 'completed' : '';
        li.innerHTML = `
            <span onclick="toggleTaskCompletion(${task.id})">${task.text}</span>
            <div>
                <button onclick="editTask(${task.id})">Edit</button>
                <button onclick="deleteTask(${task.id})">Delete</button>
            </div>
        `;
        taskListElement.appendChild(li);
    });
}
