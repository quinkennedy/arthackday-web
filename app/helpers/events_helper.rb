module EventsHelper
	def order_participants(participants)
		partHash = Hash.new

		# loop through participants
		participants.each do |part|
			# get first letter of participant's name
			k = part.name.upcase[0,1]
			if !partHash.key?(k)
				# if key doesn't exist, add it
				partHash[k] = []
			end
			partHash[k] << part
		end


		partHash.keys.sort.each do |p|
			# alphabetize the names in each of the arrays
			partHash[p].sort! { |a,b| a.name.downcase <=> b.name.downcase }
		end

		return partHash
	end

	def participant_breaks(participants,count)
		# spacing here is to make up for the letter spacing
		# above each section. one unit is essentially the height
		# of one participant. this is sloppy science folks.
		spacingCount = 10;
		count = count + (participants.count * spacingCount)
		breakPoint = count/3
		breakLetters = []
		amount = 0

		# puts participants.count
		participants.keys.sort.each do |p|
			amount = amount + participants[p].count + spacingCount
			if amount > breakPoint && breakLetters.count == 0
				breakLetters << p
			elsif amount > (breakPoint * 2) && breakLetters.count == 1
				breakLetters << p
			end
		end

		return breakLetters
	end


	def google_map_search(venue)
		location = ''
		to_check = ['address', 'city', 'country']
		
		to_check.each do |check|
			if venue[check]
				venue[check].downcase!
				venue[check].gsub! /\s+/, '+'
				location = location + venue[check] + ",+"
			end
		end 
		
		return location
	end
end
