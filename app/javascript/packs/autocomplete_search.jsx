import React, { useState, useEffect } from 'react'
import ReactDOM from 'react-dom'
import debouncer from '../classes/debouncer'

const SEARCH_URL = '/items/autocomplete?term=:term'

const showResults = (results) => {
  return results.map(result => {
    return (
      <div id={`search-result-${result.id}`} className='search-result-item'>
        {result.id && <a target='_blank' href={`/items/${result.id}`}>{result.title}</a>}
        {!result.id && <p>{result}</p>}
      </div>
    )}
  )
}

const AutocompleteSearch = () => {
  const [searchPhrase, setSearchPhrase] = useState('')
  const handleAutocompleteInputChange = (event) => setSearchPhrase(event.target.value)

  const [isSearching, setIsSearching] = useState(false)
  const [results, setResults] = useState([])

  const debouncedSearchTerm = debouncer(searchPhrase, 500)

  useEffect(
    async () => {
      if (debouncedSearchTerm) {
        setIsSearching(true)
        const response = await fetch(SEARCH_URL.replace(':term', debouncedSearchTerm))
        const result = await response.json()
        setResults(result)
        setIsSearching(false)
      } else {
        setResults([])
      }
    },
    [debouncedSearchTerm]
  )

  return(
    <div className='search-block'>
      <input
        type='search'
        placeholder='Search'
        className='search-input'
        value={searchPhrase}
        onChange={handleAutocompleteInputChange}
      />

      {isSearching && <div className='search-result'>{showResults(['Searching...'])}</div>}
      {!isSearching &&
        debouncedSearchTerm &&
        results.length === 0 &&
        <div className='search-result'>{showResults(['Not Found'])}</div>}

      {results.length > 0 && <div className='search-result'>{showResults(results)}</div>}
    </div>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  const autocompleteSearchAnchor = document.getElementById('autocomplete-search')
  if (!autocompleteSearchAnchor) return

  ReactDOM.render(
    <AutocompleteSearch />,
    autocompleteSearchAnchor,
  )
})

export default AutocompleteSearch
