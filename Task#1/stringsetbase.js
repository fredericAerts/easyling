class StringSet extends Set {
    /**
     * Constructor
     * @param {String[]} [elements]
     */
    constructor(elements) {
        if (elements && !Array.isArray(elements)) {
            throw new Error('Constructor param needs to be of type Array');
        }

        if (elements && elements.some(value => typeof value !== 'string')) {
            throw new Error('Constructor param needs to be an array of strings');
        }

        super(elements);
    }

    /**
     * Adds a new element to the set
     * @param {String} element
     */
    add(element) {
        if (typeof element !== 'string') {
            throw new Error('Add method requires string as a parameter');
        }

        return super.add(element);
    }

    /**
     * Removes and element from the set
     * @param {String} element
     */
    remove(element) {
        if (typeof element !== 'string') {
            throw new Error('Remove method requires string as a parameter');
        }

        return super.delete(element);
    }

    /**
     * Decides if element is part of the set
     * @param {String} element
     * @return {Boolean}
     */
    contains(element) {
        if (typeof element !== 'string') {
            throw new Error('Contains method requires string as a parameter');
        }

        return super.has(element);
    }
}
