export enum UserStatus {
  Active = 1,
  Suspended = 2,
  Deleted = 3,
  Banned = 4,
}

export enum ActivityStatus {
  Open = 1,
  Full = 2,
  Completed = 3,
  Cancelled = 4,
}

export enum ReportStatus {
  Pending = 1,
  Reviewing = 2,
  Resolved = 3,
  Dismissed = 4,
}

export interface ApiResponse<T> {
  success: boolean;
  data: T;
  message?: string;
}

export interface PagedResponse<T> {
  items: T[];
  totalCount: number;
  page: number;
  pageSize: number;
  totalPages: number;
  hasNextPage: boolean;
  hasPreviousPage: boolean;
}

export interface AuthResponse {
  accessToken: string;
  refreshToken: string;
  expiresAt: string;
  userId: string;
  role: string;
  displayName?: string;
  isNewUser: boolean;
}

export interface AdminTokenPayload {
  sub: string;
  role: string;
  displayName: string;
  exp: number;
}

export interface DashboardStats {
  totalUsers: number;
  verifiedUsers: number;
  activeActivities: number;
  todayActivities: number;
  pendingReports: number;
  averageRating: number;
  registrationsByDay: DailyCountItem[];
  activitiesByDay: DailyCountItem[];
  categoryDistribution: CategoryCountItem[];
}

export interface DailyCountItem {
  date: string;
  count: number;
}

export interface CategoryCountItem {
  categoryName: string;
  count: number;
}

export interface AdminUserListItem {
  id: string;
  phoneNumber: string;
  isPhoneVerified: boolean;
  email?: string;
  status: UserStatus;
  createdAt: string;
  lastLoginAt?: string;
  displayName: string;
  avatarUrl?: string;
  averageRating: number;
  reviewCount: number;
  completedActivityCount: number;
}

export interface AdminUserDetail extends AdminUserListItem {
  bio?: string;
  reportCount: number;
  createdActivityCount: number;
  recentActivities: UserActivityItem[];
  recentReports: UserReportItem[];
}

export interface UserActivityItem {
  id: string;
  title: string;
  categoryName: string;
  eventDate: string;
  status: string;
}

export interface UserReportItem {
  id: string;
  reason: string;
  status: string;
  createdAt: string;
}

export interface ActivityListItem {
  id: string;
  createdByUserId: string;
  createdByDisplayName: string;
  categoryId: string;
  categoryName: string;
  title: string;
  eventDate: string;
  neededPeopleCount: number;
  currentPeopleCount: number;
  status: ActivityStatus;
  latitude: number;
  longitude: number;
  addressText: string;
  createdAt: string;
}

export interface AdminActivityDetail extends ActivityListItem {
  description?: string;
  pricePerPerson?: number;
  skillLevel: string;
  genderPreference: string;
  addressDetailPrivate?: string;
  createdByAvatarUrl?: string;
  participants: ParticipantItem[];
  joinRequests: JoinRequestItem[];
}

export interface ParticipantItem {
  userId: string;
  displayName: string;
  avatarUrl?: string;
  joinedAt: string;
}

export interface JoinRequestItem {
  id: string;
  userId: string;
  displayName: string;
  status: string;
  requestedAt: string;
}

export interface ReportItem {
  id: string;
  reporterUserId: string;
  reportedUserId?: string;
  reportedActivityId?: string;
  reason: string;
  details?: string;
  status: ReportStatus;
  createdAt: string;
  resolvedAt?: string;
}

export interface AdminReviewItem {
  id: string;
  activityId: string;
  activityTitle: string;
  reviewerUserId: string;
  reviewerDisplayName: string;
  reviewerAvatarUrl?: string;
  reviewedUserId: string;
  reviewedDisplayName: string;
  rating: number;
  comment?: string;
  isHidden: boolean;
  createdAt: string;
}

export interface AdminCategoryItem {
  id: string;
  name: string;
  slug: string;
  iconName?: string;
  color?: string;
  sortOrder: number;
  isActive: boolean;
  activityCount: number;
  imageUrl?: string | null;
  imageIsCustom?: boolean;
}

export interface AdminCategoryRequest {
  name: string;
  slug: string;
  iconName?: string;
  color?: string;
  sortOrder: number;
  isActive: boolean;
}
