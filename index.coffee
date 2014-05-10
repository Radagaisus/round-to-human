# Rounds `x` to the nearest multiple of `m`. `round(2.5, 5)` will round the number
# upwards to 5. `round(2.49, 5)` will round it down to 0.
# 
# Example usage:
#   round 13, 5
#   > 15
#   
#   round 8, 10
#   > 10
#   
#   round 23, 13
#   > 26
#
# @param x - {Number} the number we want to round
# @param m - {Number} the number we want to round to a multiple of.
# 
# See: http://en.wikipedia.org/wiki/Rounding for the algorithm
#
round =  (x, m) ->
	# Divide x by m, let the result be y;
	y = x / m
	# Round y to an integer value, call it q;
	q = Math.round y
	# Multiply q by m to obtain the rounded value.
	q * m


# Will return a nice rounded number that's easily digestible by humans. This is
# useful, for example, to programmatically generate an ever increasing number of
# bonus points, without generating numbers that look "weird".
# 
# @param n - {Number} the number we want to round
# @param options - {Object}:
#   - threshold - Start rounding numbers only if they're above the threshold. By
#     default, 10.
#   - multiple - The multiple to use. Set to 10 by default. 5 is also recommended.
#   - upwards - whether to always round upwards or not.
#   - significant - number of significant digits to keep
# 
module.exports = round_to_human = (n, options = {}) ->
	# Set the threshold to 10 by default.
	options.threshold ||= 10
	# Set the multiple to 10 by default.
	options.multiple ||= 10
	# Set the significant digits to 2 by default
	options.significant ||= 2
	# Set the upward setting to true by default
	options.upwards ?= true
	# Round N to an integer
	n = Math.round(n)
	# Return the rounded number if it's lesser than or equal to the threshold
	return n if n <= options.threshold
	# Get the exponent we use to get the `len` of the round up. We calculate it based
	# on the number of digits in the number minus the significant digits required minus
	# one.
	exponent = n.toString().length - options.significant - 1
	# Now, get the length, by squaring 10 with the exponent and multiplying by the multiple
	len = Math.pow(10, exponent) * options.multiple
	# Get the maximum between the multiple and the length, in case the digits in
	# the number are lesser than or equal to the significant digits
	len = Math.max(options.multiple, len)
	# If the upwards option is set, and the number doesn't divide squarely in `len`
	# Round the number plus half of the length with the length. Otherwise, just round
	# the number itself in the length.
	if options.upwards and n % len
	then round(n + len / 2 - 0.1, len)
	else round(n, len)
