package model

// due to no union/enums in language, AttachmentType = string
type AttachmentType string

type Attachment struct {
	id       DbId
	attType  AttachmentType
	resource DbRef[Resource]
	title    *string
}
