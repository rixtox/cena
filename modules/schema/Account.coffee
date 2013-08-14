mongoose = require 'mongoose'

exports = module.exports = (app) ->
	accountSchema = new mongoose.Schema
		user:
			id:
				type: mongoose.Schema.Types.ObjectId
				ref: 'User'
			name:
				type: String
				default: ''
		name:
			full:
				type: String
				default: ''
			first:
				type: String
				default: ''
			middle:
				type: String
				default: ''
			last:
				type: String
				default: ''
		company:
			type: String
			default: ''
		phone:
			type: String
			default: ''
		zip:
			type: String
			default: ''
		status:
			id:
				type: String
				ref: 'Status'
			name:
				type: String
				default: ''
			userCreated:
				id:
					type: mongoose.Schema.Types.ObjectId
					ref: 'User'
				name:
					type: String
					default: ''
				time:
					type: Date
					default: Date.now
		statusLog: [mongoose.modelSchemas['StatusLog']]
		notes: [mongoose.modelSchemas['Note']]
		userCreated:
			id:
				type: String
				default: ''
			name:
				type: String
				default: ''
			time:
				type: Date
				default: Date.now
		search: [String]

	accountSchema.plugin require './plugins/pagedFind'
	accountSchema.index user: 1
	accountSchema.index 'status.id': 1
	accountSchema.index search: 1
	accountSchema.set 'autoIndex', app.get 'env' == 'development'
	app.db.model 'Account', accountSchema