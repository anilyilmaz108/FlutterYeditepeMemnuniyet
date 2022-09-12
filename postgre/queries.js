const Pool = require('pg').Pool
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'satisfactiondb',
  password: '176369',
  port: 5432,
})
const getUsers = (request, response) => {
  pool.query('SELECT * FROM shares ORDER BY id ASC', (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}
const getUserById = (request, response) => {
  const id = parseInt(request.params.id)

  pool.query('SELECT * FROM shares WHERE id = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const createUser = (request, response) => {
  const { name, email, status, datetime, comment, complaint} = request.body

  pool.query('INSERT INTO shares (name, email, status, datetime, comment, complaint) VALUES ($1, $2, $3, $4, $5, $6)', [name, email, status, datetime, comment, complaint], (error, results) => {
    if (error) {
      throw error
    }
    response.status(201).send(`User added with ID: ${results.insertId}`)
  })
}

const updateUser = (request, response) => {
  const id = parseInt(request.params.id)
  const { name, email, status, datetime, comment, complaint} = request.body

  pool.query(
    'UPDATE shares SET name = $1, email = $2, status = $3, datetime = $4, comment = $5, complaint = $6, WHERE id = $7',
    [name, email, status, datetime, comment, complaint, id],
    (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).send(`User modified with ID: ${id}`)
    }
  )
}

const deleteUser = (request, response) => {
  const id = parseInt(request.params.id)

  pool.query('DELETE FROM shares WHERE id = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).send(`User deleted with ID: ${id}`)
  })
}

module.exports = {
  getUsers,
  getUserById,
  createUser,
  updateUser,
  deleteUser,
}