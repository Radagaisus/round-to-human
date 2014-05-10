assert = require 'assert'
round_to_human = require '../index'

describe 'round-to-human', ->
	
	it 'returns the first 10 numbers unharmed', ->
		for i in [0..10]
			res = round_to_human(i)
			assert.equal res, i

	it 'returns numbers below the threshold unharmed', ->
		for i in [0..100]
			res = round_to_human(i, threshold: 100)
			assert.equal res, i

	it 'rounds floats to integers', ->
		res = round_to_human(1.1)
		assert.equal res, 1

		res = round_to_human(123.52)
		assert.equal res, 130

	it 'rounds the numbers to the nearest multiple of 10', ->
		res = round_to_human(11)
		assert.equal res, 20

		res = round_to_human(110)
		assert.equal res, 110

		res = round_to_human(1100)
		assert.equal res, 1100

		res = round_to_human(11100)
		assert.equal(res, 12000)


	it 'rounds with different multiple', ->
		res = round_to_human(11, multiple: 5)
		assert.equal res, 15

		res = round_to_human(110, multiple: 5)
		assert.equal res, 110

		res = round_to_human(1100, multiple: 5)
		assert.equal res, 1100

		res = round_to_human(1150, multiple: 5)
		assert.equal res, 1150

		res = round_to_human(11100, multiple: 5)
		assert.equal(res, 11500)

		res = round_to_human(136432, multiple: 5)
		assert.equal(res, 140000)

		res = round_to_human(133432, multiple: 5)
		assert.equal(res, 135000)

		res = round_to_human(23, multiple: 2)
		assert.equal(res, 24)

		res = round_to_human(2322, multiple: 2)
		assert.equal(res, 2340)


	it 'rounds downwards', ->
		res = round_to_human(110, upwards: false)
		assert.equal(res, 110)

		res = round_to_human(113, upwards: false)
		assert.equal(res, 110)


	it 'rounds to different number of significant digits', ->
		res = round_to_human(23423, significant: 5)
		assert.equal(res, 23430)

		res = round_to_human(1234567890123, significant: 10)
		assert.equal(res, 1234567891000)


	# Just output the numbers for sanity check
	console.log "-------------------------------------------------"
	t = 1
	for j in [0..200]
		t *= 1.15
		console.log "#{t}: #{round_to_human(t, multiple: 5)}"
	console.log "-------------------------------------------------"

