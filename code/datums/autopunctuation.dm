GLOBAL_DATUM_INIT(needs_eol_autopunctuation, /regex, regex(@"([a-zA-Z\dа-яА-ЯёЁ]|[^.?!~-][+|_])$"))

GLOBAL_DATUM_INIT(noncapital_i, /regex, regex(@"\b[и]\b", "g"))

/proc/autopunct_bare(input_text)
    if (findtext(input_text, GLOB.needs_eol_autopunctuation))
        input_text += "."

    input_text = replacetext(input_text, GLOB.noncapital_i, "И")
    return input_text
