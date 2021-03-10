# template adapter
# Underscore's Template Module
# Courtesy of underscorejs.org

class UnderscoreTemplateAdapter
  constructor: () ->
    this

  # JavaScript micro-templating, similar to John Resig's implementation.
  # Underscore templating handles arbitrary delimiters, preserves whitespace,
  # and correctly escapes quotes within interpolated code.
  tmpl: (text, data) ->
    # var render

    _ = {}

    # List of HTML entities for escaping.
    entityMap =
      escape:
        '&': '&amp;'
        '<': '&lt;'
        '>': '&gt;'
        '"': '&quot;'
        # jshint quotmark:false
        "'": '&#x27;'
        '/': '&#x2F;'

    escapeKeys = '&<>"\'/'
    unescapeKeys = '&amp;|&lt;|&gt;|&quot;|&#x27;|&#x2F;'

    # Regexes containing the keys and values listed immediately above.
    entityRegexes =
      escape:   new RegExp('[' + escapeKeys + ']', 'g')
      unescape: new RegExp('(' + unescapeKeys + ')', 'g')

    # Functions for escaping and unescaping strings to/from HTML interpolation.
    ['escape', 'unescape'].forEach((method) ->
      _[method] = (string) ->
        if string == null || string == undefined
          return ''

        ('' + string).replace(entityRegexes[method], (match) ->
          entityMap[method][match]
        )
    )

    settings =
      evaluate: /<%([\s\S]+?)%>/g
      interpolate: /<%=([\s\S]+?)%>/g
      escape: /<%-([\s\S]+?)%>/g

    noMatch = /(.)^/
    escapes =
      # jshint quotmark:false
      "'": "'"
      '\\': '\\'
      '\r': 'r'
      '\n': 'n'
      '\t': 't'
      '\u2028': 'u2028'
      '\u2029': 'u2029'

    escaper = /\\|'|\r|\n|\t|\u2028|\u2029/g

    # Combine delimiters into one regular expression via alternation.
    matcher = new RegExp([
      (settings.escape || noMatch).source,
      (settings.interpolate || noMatch).source,
      (settings.evaluate || noMatch).source
    ].join('|') + '|$', 'g')

    # Compile the template source, escaping string literals appropriately.
    index = 0
    source = "__p+='"
    text.replace(matcher, (match, escape, interpolate, evaluate, offset) ->
      source += text.slice(index, offset)
      .replace(escaper, (match) ->
        return '\\' + escapes[match]
      )

      if escape
        source += "'+\n((__t=(" + escape + "))==null?'':_.escape(__t))+\n'"
      if interpolate
        source += "'+\n((__t=(" + interpolate + "))==null?'':__t)+\n'"
      if evaluate
        source += "';\n" + evaluate + "\n__p+='"
      index = offset + match.length

      match
    )
    source += "';\n"

    # If a variable is not specified, place data values in local scope.
    if not settings.variable
      source = 'with(obj||{}){\n' + source + '}\n'

    source = "var __t,__p='',__j=Array.prototype.join," +
      "print=function(){__p+=__j.call(arguments,'');};\n" +
      source + "return __p;\n"

    try
      # jshint evil:true
      render = new Function(settings.variable || 'obj', '_', source)
    catch err
      err.source = source
      throw err

    if data
      return render(data, _)

    template = (data) ->
      render.call(this, data, _)

    # Provide the compiled function source as a convenience for precompilation.
    template.source = 'function(' + (settings.variable || 'obj') + '){\n' + source + '}'

    template

module.exports = UnderscoreTemplateAdapter
