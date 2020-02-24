# pseudo code
class BoggleSearchTest
    require 'matrix'
    
    # initialize method is part of the object-creation process in Ruby & it allows you to set the initial values for an object
    # like constructor in JAVA
    def initialize()
    end


# $matrix = Matrix[ ["a","b","c","d"],
                #    ["e","f","g","h"],
                #    ["i","j","k","l"],
                #    ["m","n","o","p"] ]

# test with 2X2 matrix
    $matrix1 = Matrix[
        ["a","b"],
        ["e","f"]]

    # global variables
    $initialCoordinate
    $beginWith
    $possibleWords = []


    def findAllPossibleWords()
        $matrix1.each_with_index do |e, row, col|
            puts "#{e} at #{row}, #{col}"
            work([row,col],$matrix1[row,col])
        end
        puts $possibleWords
    end

    def work(coordinate,value)
        $beginWith = coordinate;
        
        startT(coordinate,value,[coordinate])

    end

    def startT(coordinate,value,visitedCoordinates)
        hashList = []
        hash = Hash.new
        hash["possibleWords"] = value
        hash["visitedCoordinate"] = coordinate
        $possibleWords.push(value);
        hashList.push(hash)
        coordinateValueParent = checkCoordinateValue(coordinate)
            if coordinateValueParent != nil
                toBeTraversed = []
                getNeighbourOfThisCoordinate(coordinate).compact.each { |n|
                    if visitedCoordinates.none? n
                        toBeTraversed.push(n)               
                    end
                }
                if toBeTraversed != nil
                    traverseNeighbour(toBeTraversed,hash,hashList)
                end
            end
    end
 
    def traverseNeighbour(toBeTraversed,hash,hashList)
        toBeTraversed.each { |t| 
            hashList1 = []
            hashList1.push(hash)
            hash1 = Hash.new
            hash1["possibleWords"] = hash["possibleWords"]+$matrix1[t[0],t[1]]
            hash1["visitedCoordinate"] = t
            hashList1.push(hash1) 
            value= hash1["possibleWords"]
            $possibleWords.push(value)
            vlist= []
            hashList.each { |h|
                vlist.push(h["visitedCoordinate"])
            }
            coordinateValueParent = checkCoordinateValue(t)
            if coordinateValueParent != nil
                toBeTraversed1 = []
                getNeighbourOfThisCoordinate(t).compact.each { |n|
                    if vlist.none? n
                        toBeTraversed1.push(n)               
                    end
                } 
                if toBeTraversed1 != nil
                    if toBeTraversed1.size() ==1 && toBeTraversed1[0] == $beginWith
                        # print "end"
                        # puts
                    else
                        traverseNeighbour(toBeTraversed1,hash1,hashList1)
                    end
                end
            end
        }
    end

    def getNeighbourOfThisCoordinate(coordinate)
        coordinateValue = checkCoordinateValue(coordinate)
        if coordinateValue != nil
            return getNeighbours(coordinate)
        end
    end

    def getNeighbours(coordinate)
        coordinateTopValue = checkCoordinateValue([coordinate[0]-1,coordinate[1]])
        coordinateTopRightValue = checkCoordinateValue([coordinate[0]-1,coordinate[1]+1])
        coordinateRightValue = checkCoordinateValue([coordinate[0],coordinate[1]+1])
        coordinateButtomRightValue = checkCoordinateValue([coordinate[0]+1,coordinate[1]+1])
        coordinateButtomValue = checkCoordinateValue([coordinate[0]+1,coordinate[1]])
        coordinateButtomLeftValue = checkCoordinateValue([coordinate[0]+1,coordinate[1]-1])
        coordinateLeftValue = checkCoordinateValue([coordinate[0],coordinate[1]-1])
        coordinateTopLeftValue = checkCoordinateValue([coordinate[0]-1,coordinate[1]-1])

        return [coordinateTopValue, coordinateTopRightValue, coordinateRightValue,
             coordinateButtomRightValue, coordinateButtomValue, coordinateButtomLeftValue,
            coordinateLeftValue, coordinateTopLeftValue]
    end

    def checkCoordinateValue(coordinate)
        return nil if coordinate[0]<0 || coordinate[1]<0
        return coordinate if $matrix1[coordinate[0],coordinate[1]]!=nil && (coordinate[0]>=0 || coordinate[1]>=0)
    end
    
end

b = BoggleSearchTest.new()
b.findAllPossibleWords