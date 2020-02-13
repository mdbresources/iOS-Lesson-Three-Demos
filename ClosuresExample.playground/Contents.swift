var double: (Int) -> Int = {
    num in
    return num * 2
}

double(2)

func exampleFunction(closure: (Int) -> ()) {
    print("Hi, I'm running my example function")
    closure(3)
}

// Way 1 of Calling a Function with a Closure
exampleFunction(closure: { integer in
    print(integer + 2)
})

// Way 2 of Calling a Function with a Closure
exampleFunction() { num in
    print(num + 2)
}

let sortedArr = [1, 6, 3, 4, 7, 2, 1, 4].sorted { $0 > $1 }
let filteredArr = [1, 6, 3, 4, 7, 2, 1, 4].filter { (num) -> Bool in
    return num % 2 == 0
}
